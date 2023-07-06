echo -e "\e[33m Install golang \e[0m"
yum install golang -y &>>/tmp/roboshop.log

echo -e "\e[33m Add Application user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m Add application Directory \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[33m Download application content & unzip\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log

echo -e "\e[33m download dependencies\e[0m"
cd /app
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "\e[33m setup systemd file \e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[33m restart services \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl restart dispatch &>>/tmp/roboshop.log