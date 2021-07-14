gcloud auth application-default login

export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install gcsfuse

gsutil mb gs:// bicaraitcom-fuse-wordpress-storage 
sudo mkdir /var/www/gcs-fuse
sudo gcsfuse --implicit-dirs bicaraitcom-fuse-wordpress-storage /var/www/gcs-fuse
sudo mkdir /var/www/gcs-fuse/wordpress
sudo cp -rf /var/www/html/* /var/www/gcs-fuse/wordpress/

#change your apache config to new destination above

sudo systemctl restart apache2
sudo systemctl enable apache2

sudo nano /etc/rc.local
sudo chmod a+x /etc/rc.local 

#Content of the /etc/rc.local :
#/bin/bash
gcsfuse --implicit-dirs bicaraitcom-wwwhtml-wordpress /var/www/html-fuse/
