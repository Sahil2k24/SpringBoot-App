pipeline {
    agent any
    tools {
        maven "MAVEN3"
        jdk "OracleJDK17"
    }

    stages {
        stage('FETCHING CODE') {
            steps {
                // Checkout code from GitHub using personal access token
                git branch: 'QA', url: 'https://github.com/Sahil2k24/SpringBoot-App.git'
            }
        }

        stage('BUILDING') {
            steps {
                sh 'mvn clean install -DskipTests'
                sh 'cp /var/lib/jenkins/workspace/smart/target/SmartContactManger-0.0.1-SNAPSHOT.war .'
            }
        }

        stage('TESTING') {
            steps {
                sh 'mvn test'
            }
        }

        stage('CHECKSTYLE ANALYSIS'){
            steps{
                sh 'mvn checkstyle:checkstyle'
            }
        }

        stage('SONARQUBE CODE ANALYSIS') {
            steps {
              withSonarQubeEnv('sonar') {
                sh ''' mvn clean verify sonar:sonar \
                -Dsonar.projectKey=smart \
                -Dsonar.projectName=smart \
                -Dsonar.host.url=http://'public_ip':9000 \
                -Dsonar.login=sqp_60d7958f7377c67016ff74332fcaa3ffec09592a '''
                
              }
        }
     }

        stage("QUALITY GATE") {
            steps {
              timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
          }
 
        stage('CREATING DOCKER IMAGE'){
            steps{
                sh 'docker build -t qa-spring-boot .'
            }
        }

        stage('CREATING DOCKER CONTAINER'){
            steps{
                sh 'docker run -d -p 9090:8087 --network=host qa-spring-boot'
            }
        }

        stage('APPLICATION STARTED !'){
            steps{
                echo "Your application is containerized and is running smoothly...!"
            }
        }

    }
}
