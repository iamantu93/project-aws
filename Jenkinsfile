pipeline {
    agent any
parameters {
        string(name: 'PERSON', defaultValue: 'Antu Acharjee', description: 'Who should I say hello to?')
        choice(name: 'DEPARTMENT', choices: ['DevOps', 'Java EE', 'iOS', 'Android'], description: 'Pick a department')

    }
    environment {
        BRANCH = "master"
        GIT_REPO = "https://github.com/iamantu93/project-aws.git"
    }
    
    triggers {
        pollSCM('H/2 * * * *') // Polls the SCM every 2 minutes
    }
tools {
    maven 'MAVEN-3.6.3' 
    jdk 'JAVA_11'
    git 'Git-2.39.3'
}
stages {
    stage('git clone') {
        steps {
            echo 'cloning git repository'
            git branch: "${BRANCH}", url: "${GIT_REPO}"

        } 
    }   
    stage('Build stage') {
        steps {
            script {
                echo 'This is build stage'
                sh 'mvn clean package -X'
            }
        } 
    }

    stage('Test stage') {
        steps {
            echo 'This is Test stage'
        } 
    }
    
    stage('Deploy stage') {
        steps {
            echo 'This is deploy stage'
            script{
                sshagent(['EC2']) {
                    sh 'scp -o StrictHostKeyChecking=no target/spark-lms-0.0.1-SNAPSHOT.jar ec2-user@54.244.201.42:/home/ec2-user'
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@54.244.201.42 'start' "
                }
            }
            
        } 
    }
    
 }
post { 
    success { 
        cleanWs()
        echo 'Status is green'
        echo "successfully built and deployed by ${PERSON}"
        echo "A proud ${DEPARTMENT} engineer"
    }

    failure{
        cleanWs()
        echo 'Status is red'
    }

    unstable{
        cleanWs()
        echo "Build is unstable"
    }
}
}
