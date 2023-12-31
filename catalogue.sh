echo -e "\e[33mConfigurung nodejs repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33mInstall nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33m add application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mCreate application directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app

echo -e "\e[33mDownload application content\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33mExtract application content\e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app

echo -e "\e[33mInstalling nodejs dependencies\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[33mSetup SystemD service\e[0m"
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[33mStart Catalogue service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl start catalogue &>>/tmp/roboshop.log

echo -e "\e[33mCopy Mongodb Repo file\e[0m"
cp /home/centos/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstalling MongoDB Client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[33mLoad Schema\e[0m"
mongo --host mongodb-dev.pandudevopsb72.store </app/schema/catalogue.js &>>/tmp/roboshop.log