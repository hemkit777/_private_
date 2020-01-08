# LENDABLE PROJECT TASK

TODO: Automated deployment solution of Static Web Contents/HTML in Ngnix docker container. 

## Installation

TODO: Solution is degsin to automated way to pull Static Web Contents from the github repository, check already docmer container and image exists if exists then stop the container and delete image before initiate building new image.

User have to simply run below commands to deploy project:

1) Pull Project Repository 
   git clone https://github.com/hemkit777/_private_.git
2) Navigate _private_ dir
   cd _private_
   
## Usage

TODO: User have to simply run below script to pull source code of static contents, create docker build and start container:

1) Execute script 
   ./build_deploy.sh

Above script will first check docker image if exists then it check if any (running or non running) container associate to image. If container is associate to image then first stop container if it is running and then delete conatiner before deleting image. Once container is deleted, script deletes images prior to pull source code and build new image.


## Credits

TODO: Writer - Hemant Bhavsar
