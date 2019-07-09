def label = "worker-${UUID.randomUUID().toString()}"
def gitCommit = ""

podTemplate(label: label, containers: [
  containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),
],
volumes: [
  hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
]) {
  node(label) {
    def myRepo = checkout scm
    gitCommit = myRepo.GIT_COMMIT
    def gitBranch = myRepo.GIT_BRANCH
 
    stage('Set Env') {
      try {
        container('docker') {
          sh """
            pwd
            echo "GIT_BRANCH=${gitBranch}" >> /etc/environment
            echo "GIT_COMMIT=${gitCommit}" >> /etc/environment
            """
        }
      }
      catch (enverror) {
        println "Failed to test - ${currentBuild.fullDisplayName}"
        throw(enverror)
      }
    }
    stage('Build') {
      container('docker') {
          sh """
            cd notejam;
            docker build . -t docker-registry:31000/notejam:${gitCommit};
            docker push docker-registry:31000/notejam:${gitCommit};
            """
      }
    }
  }
}

podTemplate(label: label, containers: [
containerTemplate(name: 'app', image: "docker-registry:31000/notejam:${gitCommit}", command: 'cat', ttyEnabled: true),
containerTemplate(name: 'mariadb', image: 'mariadb', ttyEnabled: true,
    envVars: [envVar(key: 'MYSQL_ALLOW_EMPTY_PASSWORD', value: 'yes')],
    ports: [portMapping(name: 'mysql', containerPort: 3306, hostPort: 3306)]
),
containerTemplate(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl:v1.8.8', command: 'cat', ttyEnabled: true),
],
volumes: [
hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
]) {
node(label) {
    stage('Test Image') {
        container('app') {
            sh """
                cd /app
                bash test.sh
                """
        }            
    }
    stage('Deploy Image to production') {
        container('kubectl') {
            sh "kubectl set image deployment notejam-app notejam-app=docker-registry:31000/notejam:${gitCommit}"
            }
        }
    }
}