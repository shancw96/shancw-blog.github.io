highlight='\033[0;31m'
NC='\033[0m'
echo "${highlight}---------------------------------------------${NC}"
echo setting http proxy to http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
echo "${highlight}---------------------------------------------${NC}"
echo "${highlight}---------------------------------------------${NC}"
date
echo building local static file...
echo "${highlight}---------------------------------------------${NC}"

npm run build
echo "${highlight}---------------------------------------------${NC}"
date
echo building docker image...
echo "${highlight}---------------------------------------------${NC}"
docker rmi --force 192.168.193.72:5000/blog:latest
docker build . -t 192.168.193.72:5000/blog:latest --no-cache
echo "${highlight}---------------------------------------------${NC}"
date
echo pushing docker image...
echo "${highlight}---------------------------------------------${NC}"

docker push 192.168.193.72:5000/blog:latest
echo "${highlight}---------------------------------------------${NC}"
date
echo sync to github
echo "${highlight}---------------------------------------------${NC}"
time=$(date "+%Y-%m-%d %H:%M:%S")
echo "please input commit message"
read message
git add .
git commit -m "${message}"
echo "auto deploy at:${time}" >> deploy.tag
git add .
git commit -m "auto deploy at ${time}"
git push origin master
echo "${highlight}---------------------------------------------${NC}"
date
echo deploy success!
echo "${highlight}---------------------------------------------${NC}"
exit 0