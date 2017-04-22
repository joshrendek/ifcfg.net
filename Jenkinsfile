pipeline {
    agent any
    stages {
        stage("Deploy") {
            steps {
                checkout scm
                echo "BRANCH: ${env.BRANCH_NAME}"
                sh 'rm -rf .git'
                sh 'git init .'
                sh 'git remote add dokku dokku@web2.joshrendek.com:ifcfg || true'
                //sh "git checkout ${env.BRANCH_NAME}"
                //sh "git pull ${env.BRANCH_NAME}"
                //sh 'git pull'
                //sh 'git fetch origin master'
                sh 'git config --global user.name "jenkins"'
                sh 'git config --global user.email "builds@ci.joshrendek.com"'
                sh 'git add .'
                sh 'git commit -m "Deploy to dokku"'
                sh 'git push -f dokku master'
                deleteDir()
            }
        }

    }
}
