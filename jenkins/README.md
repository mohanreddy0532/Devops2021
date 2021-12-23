Project with Jenkins 

Install Jenkins:
https://pkg.jenkins.io/redhat-stable/

curl https://pkg.jenkins.io/redhat-stable/jenkins.repo > /etc/yum.repos.d/jenkins.repo
cat /etc/yum.repos.d/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

yum install epel-release # repository that provides 'daemonize';
yum install java-11-openjdk-devel;
yum install jenkins;

systemctl enable jenkins;
systemctl start jenkins;
systemctl status jenkins;

netstat -lntp

tcp6       0      0 :::8080                 :::*                    LISTEN      4350/java   

