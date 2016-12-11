all:
	cp /home/meco/.rclone.conf .
	sudo docker build -t meco . 
