#! /bin/bash

set -e

ossfsv='ossfs_1.80.5_centos7.0_x86_64.rpm'
wget http://gosspublic.alicdn.com/ossfs/$ossfsv
sudo yum localinstall -y $ossfsv

arr_bucket=(djangotest jiangkehot univerdream-aliyun-bill univerdream-bj-registry univerdream-etc)
thepwd=/data/ossfs/

# make directory

for dir in ${arr_bucket[@]} ;do 
    [ -d ${thepwd}${dir} ] || mkdir ${thepwd}${dir}
done

# config
source /data/root/.ssh/AccessKey
touch /etc/passwd-ossfs
for dir in ${arr_bucket[@]} ;do
    if ! grep "$dir" /etc/passwd-ossfs; then
    	echo $dir:$AccessKeyID:$AccessKeySecret >> /etc/passwd-ossfs
    fi
done

chmod 640 /etc/passwd-ossfs

# mount
for dir in ${arr_bucket[@]} ;do
    ossfs $dir ${thepwd}${dir} -ourl=http://oss-cn-beijing-internal.aliyuncs.com
done

# 开机自动挂载
chmod +x /etc/rc.d/rc.local
echo 'sleep 5' >> /etc/rc.local
for dir in ${arr_bucket[@]} ;do
  if ! grep '$dir' /etc/rc.d/rc.local; then
      echo "ossfs $dir ${thepwd}${dir} -ourl=http://oss-cn-beijing-internal.aliyuncs.com" >> /etc/rc.local
  fi
done

## umount()
#umount_ossfs()
#{
#  # root user: umount /tmp/ossfs 
#  # non-root user: fusermount -u /tmp/ossfs 
#  for dir in ${arr_bucket[@]} ;do 
#      umount ${thepwd}${dir}/
#  done
#}
#umount_ossfs
