gcloud auth application-default login

export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install gcsfuse

gsutil mb gs://bicaraitcom-wwwhtml-wordpress
sudo mkdir /var/www/html-fuse
sudo gcsfuse --implicit-dirs bicaraitcom-wwwhtml-wordpress /var/www/html-fuse/
sudo cp -rf /var/www/html/* /var/www/html-fuse/

sudo systemctl restart apache2
sudo systemctl enable apache2

