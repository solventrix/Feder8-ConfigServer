pipeline {
    agent any

    stages {
        stage('build image') {
            steps {
                script {
                    dir('Feder8-ConfigServer') {
                        sh './build.sh'
                    }
                }
            }
        }

        stage('upload image') {
            steps {
                script {
                    dir('Feder8-ConfigServer') {
                        therapeuticAreas = ['honeur','phederation','esfurn'] // athena
                        therapeuticAreaDomains = ['honeur.org','phederation.org','esfurn.org'] //athenafederation.org
                        for (int i = 0; i < therapeuticAreas.size(); i++) {
                            try {
                                withDockerRegistry(credentialsId: "harbor-${therapeuticAreas[i]}-robot", url: "https://harbor.${therapeuticAreaDomains[i]}") {
                                    sh "THERAPEUTIC_AREA=${therapeuticAreas[i]} THERAPEUTIC_AREA_URL=harbor.${therapeuticAreaDomains[i]} ./publish.sh"
                                }
                            } catch (e) {
                                notifyPushFailed("https://harbor.${therapeuticAreaDomains[i]}")
                            }
                        }
                    }
                }
            }
        }
    }
}

def notifyPushFailed(url) {
  emailext (
      subject: "FAILED To push image",
      body: """<p>Jenkins failed to push image to ${url}</p>
        <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
      to: "sverwim1@its.jnj.com,pmoorth1@its.jnj.com"
    )
}
