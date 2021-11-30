#!/bin/bash

###################################################################
#Script Name    : Monitoring
#Description    : Container Volume monitoring, Evicted pods and description, Pod top memory, Node top memory, CrashLoopBackOff pods report generated in csv format.                  
#Args           : None
#Author         : Babu Natesan
#Email          : babu.natesan@gmail.com
#History        : 2020 NOV 18
###################################################################

KCEXEC="kubectl exec"
KC="kubectl get po"
PROD_ENV=""$(date +"%d-%m-%Y")"-FP"
#Services
MINIO_SERV=`$KC | grep minio | cut -d ' ' -f 1`
EDGE_SERV=`$KC | grep ibus-edge | cut -d ' ' -f 1`
POSTG_SERV=`$KC | grep postgres-0 | cut -d ' ' -f 1`
POSTG_COMUN_SERV=`$KC | grep camunda | cut -d ' ' -f 1`
POSTG_BACKUP_SERV=`$KC | grep postgres-backup | cut -d ' ' -f 1`
POSTG_DC_SERV=`$KC | grep postgres-dc | cut -d ' ' -f 1`
POSTG_PE_SERV=`$KC | grep postgres-pe | cut -d ' ' -f 1`
POSTG_SCHED_SERV=`$KC | grep postgres-scheduler | cut -d ' ' -f 1`
POSTG_WFM_SERV=`$KC | grep wfm | cut -d ' ' -f 1`
MONGO_SERV=`$KC | grep mongodb | cut -d ' ' -f 1 | head -1`
#MONGO_NOCODE_SERV=`$KC | grep mongodb-nocode | cut -d ' ' -f 1`
PHPLDAP_SERV=`$KC | grep php | cut -d ' ' -f 1`
PGADMIN_SERV=`$KC | grep pgadmin | cut -d ' ' -f 1`
KEYCLOAK_POSTG_SERV=`$KC | grep keycloak-postgresql-0 | cut -d ' ' -f 1`
KAFKA_0_SERV=`$KC -n kafka | grep kafka-0 | cut -d ' ' -f 1`
KAFKA_1_SERV=`$KC -n kafka | grep kafka-1 | cut -d ' ' -f 1`
KAFKA_2_SERV=`$KC -n kafka | grep kafka-2 | cut -d ' ' -f 1`

REDIS_0_SERV=`$KC -n redis-cluster | grep redis-cluster-0 | cut -d ' ' -f 1`
REDIS_1_SERV=`$KC -n redis-cluster | grep redis-cluster-1 | cut -d ' ' -f 1`
REDIS_2_SERV=`$KC -n redis-cluster | grep redis-cluster-2 | cut -d ' ' -f 1`

ELK_MAS_0_SERV=`$KC -n elk-cluster | grep elasticsearch-master-0 | cut -d ' ' -f 1`
ELK_MAS_1_SERV=`$KC -n elk-cluster | grep elasticsearch-master-1 | cut -d ' ' -f 1`
ELK_MAS_2_SERV=`$KC -n elk-cluster | grep elasticsearch-master-2 | cut -d ' ' -f 1`
LOGSTASH_SERV=`$KC -n elk-cluster | grep logstash | cut -d ' ' -f 1`

cd /root/Babu/monitoring


if [ -s $PROD_ENV-monitoring-report.csv ]
then
     echo "$PROD_ENV-monitoring-report.csv available"
         mv $PROD_ENV-monitoring-report.csv $PROD_ENV-monitoring-report.csv.old
else
echo "$PROD_ENV-monitoring-report.csv not available"
fi

echo "checking pods volume"

#Volumes
#===========================================================================
$KCEXEC $MINIO_SERV -i -t -- df -h /export | sed -n '2p' > MINIO_SERV.txt
sed -i '1s/^/minio /' MINIO_SERV.txt
cat MINIO_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC $MINIO_SERV -i -t -- df -i /export | sed -n '2p' > INODE_MINIO_SERV.txt
sed -i '1s/^/iNode-Minio /' INODE_MINIO_SERV.txt
cat INODE_MINIO_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC $EDGE_SERV -i -t -- df -h /volume | sed -n '2p' > $EDGE_SERV.txt
sed -i '1s/^/edge /' $EDGE_SERV.txt
cat $EDGE_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC $POSTG_SERV -i -t -- df -h /bitnami/postgresql | sed -n '2p' > $POSTG_SERV.txt
sed -i '1s/^/postgres /' $POSTG_SERV.txt
cat $POSTG_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC $POSTG_COMUN_SERV -i -t -- df -h /bitnami/postgresql | sed -n '2p' > $POSTG_COMUN_SERV.txt
sed -i '1s/^/camunda /' $POSTG_COMUN_SERV.txt
cat $POSTG_COMUN_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC $POSTG_BACKUP_SERV -i -t -- df -h /bitnami/postgresql | sed -n '2p' > $POSTG_BACKUP_SERV.txt
sed -i '1s/^/postgres-backup /' $POSTG_BACKUP_SERV.txt
cat $POSTG_BACKUP_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC $POSTG_DC_SERV -i -t -- df -h /bitnami/postgresql | sed -n '2p' > $POSTG_DC_SERV.txt
sed -i '1s/^/postgres-dc /' $POSTG_DC_SERV.txt
cat $POSTG_DC_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC $POSTG_PE_SERV -i -t -- df -h /bitnami/postgresql | sed -n '2p' > $POSTG_PE_SERV.txt
sed -i '1s/^/postgres-PE /' $POSTG_PE_SERV.txt
cat $POSTG_PE_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC $POSTG_SCHED_SERV -i -t -- df -h /bitnami/postgresql | sed -n '2p' > $POSTG_SCHED_SERV.txt
sed -i '1s/^/postgres-scheduler /' $POSTG_SCHED_SERV.txt
cat $POSTG_SCHED_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC $POSTG_WFM_SERV -i -t -- df -h /bitnami/postgresql | sed -n '2p' > $POSTG_WFM_SERV.txt
sed -i '1s/^/postgres-wfm /' $POSTG_WFM_SERV.txt
cat $POSTG_WFM_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC $MONGO_SERV -i -t -- df -h /bitnami/mongodb | sed -n '2p' > $MONGO_SERV.txt
sed -i '1s/^/mongo /' $MONGO_SERV.txt
cat $MONGO_SERV.txt >> $PROD_ENV-monitoring-report.txt

#$KCEXEC $MONGO_NOCODE_SERV -i -t -- df -h /bitnami/mongodb | sed -n '2p' > $MONGO_NOCODE_SERV.txt
#sed -i '1s/^/mongo-nodecode /' $MONGO_NOCODE_SERV.txt
#cat $MONGO_NOCODE_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC $PHPLDAP_SERV -i -t -- df -h / | sed -n '2p' >  $PHPLDAP_SERV.txt
sed -i '1s/^/phpldap /' $PHPLDAP_SERV.txt
cat $PHPLDAP_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC $PGADMIN_SERV -i -t -- df -h /var/lib/pgadmin | sed -n '2p' > $PGADMIN_SERV.txt
sed -i '1s/^/adadmin /' $PGADMIN_SERV.txt
cat $PGADMIN_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC $KEYCLOAK_POSTG_SERV -i -t -- df -h /bitnami/postgresql | sed -n '2p' > $KEYCLOAK_POSTG_SERV.txt
sed -i '1s/^/keycloak-postgres /' $KEYCLOAK_POSTG_SERV.txt
cat $KEYCLOAK_POSTG_SERV.txt >> $PROD_ENV-monitoring-report.txt

kubectl -n kafka exec $KAFKA_0_SERV -i -t -- df -h /opt/kafka/data | sed -n '2p' > $KAFKA_0_SERV.txt
sed -i '1s/^/kafka-0 /' $KAFKA_0_SERV.txt
cat $KAFKA_0_SERV.txt >> $PROD_ENV-monitoring-report.txt

kubectl -n kafka exec $KAFKA_1_SERV -i -t -- df -h /opt/kafka/data  | sed -n '2p' > $KAFKA_1_SERV.txt
sed -i '1s/^/kafka-1 /' $KAFKA_1_SERV.txt
cat $KAFKA_1_SERV.txt >> $PROD_ENV-monitoring-report.txt

kubectl -n kafka exec $KAFKA_2_SERV -i -t -- df -h /opt/kafka/data  | sed -n '2p' > $KAFKA_2_SERV.txt
sed -i '1s/^/kafka-2 /' $KAFKA_2_SERV.txt
cat $KAFKA_2_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC -n redis-cluster $REDIS_0_SERV -i -t -- df -h /bitnami/redis/data | sed -n '2p' > $REDIS_0_SERV.txt
sed -i '1s/^/redis-0 /' $REDIS_0_SERV.txt
cat $REDIS_0_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC -n redis-cluster $REDIS_1_SERV -i -t -- df -h /bitnami/redis/data | sed -n '2p' > $REDIS_1_SERV.txt
sed -i '1s/^/redis-1 /' $REDIS_1_SERV.txt
cat $REDIS_1_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC -n redis-cluster $REDIS_2_SERV -i -t -- df -h /bitnami/redis/data | sed -n '2p' > $REDIS_2_SERV.txt
sed -i '1s/^/redis-2 /' $REDIS_2_SERV.txt
cat $REDIS_2_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC -n elk-cluster $ELK_MAS_0_SERV -i -t -- df -h /usr/share/elasticsearch/data | sed -n '2p' > $ELK_MAS_0_SERV.txt
sed -i '1s/^/elk-master-0 /' $ELK_MAS_0_SERV.txt
cat $ELK_MAS_0_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC -n elk-cluster $ELK_MAS_1_SERV -i -t -- df -h /usr/share/elasticsearch/data | sed -n '2p' > $ELK_MAS_1_SERV.txt
sed -i '1s/^/elk-master-1 /' $ELK_MAS_1_SERV.txt
cat $ELK_MAS_1_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC -n elk-cluster $ELK_MAS_2_SERV -i -t -- df -h /usr/share/elasticsearch/data | sed -n '2p' > $ELK_MAS_2_SERV.txt
sed -i '1s/^/elk-master-2 /' $ELK_MAS_2_SERV.txt
cat $ELK_MAS_2_SERV.txt >> $PROD_ENV-monitoring-report.txt

$KCEXEC -n elk-cluster $LOGSTASH_SERV -i -t -- df -h /usr/share/logstash/data | sed -n '2p' > $LOGSTASH_SERV.txt
sed -i '1s/^/logstash /' $LOGSTASH_SERV.txt
cat $LOGSTASH_SERV.txt >> $PROD_ENV-monitoring-report.txt

echo "" >> $PROD_ENV-monitoring-report.txt
#Checking evicted pod ibus and digimops namespace
#====================================================================
echo "" >> $PROD_ENV-monitoring-report.txt
echo "Checking evicted pod ibus and digimops namespace......" >> $PROD_ENV-monitoring-report.txt
#echo "==============================================================" >> $PROD_ENV-monitoring-report.txt

kubectl get po | grep Evicted | cut -d ' ' -f 1 > Evicted.txt

if [ -s Evicted.txt ]
then
     echo "Found some Evicted pods in ibus namespace" >> $PROD_ENV-monitoring-report.txt
     for line in $(cat Evicted.txt)
           do
                #echo "===========================================================================================================" >> $PROD_ENV-monitoring-report.txt
                 kubectl describe pod $line | grep 'Name\|Node\|Message\|Liveness\|Readiness' >> $PROD_ENV-monitoring-report.txt
                #echo "===========================================================================================================" >> $PROD_ENV-monitoring-report.txt
           done
else
     echo "No Evicted pods in ibus namespace" >> $PROD_ENV-monitoring-report.txt
echo "" >> $PROD_ENV-monitoring-report.txt
fi
echo "" >> $PROD_ENV-monitoring-report.txt
kubectl get po -n digimops | grep Evicted | cut -d ' ' -f 1 > digimops-Evicted.txt

if [ -s digimops-Evicted.txt ]
then
     for line in $(cat digimops-Evicted.txt)
           do
                #echo "===========================================================================================================" >> $PROD_ENV-monitoring-report.txt
                 kubectl describe pod -n digimops $line | grep 'Name\|Node\|Message\|Liveness\|Readiness' >> $PROD_ENV-monitoring-report.txt
                #echo "===========================================================================================================" >> $PROD_ENV-monitoring-report.txt
           done
else
     echo "No Evicted pods in digimops namespace" >> $PROD_ENV-monitoring-report.txt
     echo "" >> $PROD_ENV-monitoring-report.txt
fi
echo "" >>  $PROD_ENV-monitoring-report.txt

echo "checking the node memory"  >> $PROD_ENV-monitoring-report.txt
#echo "===========================================================================================================" >> $PROD_ENV-monitoring-report.txt
echo "Worker-Node cpu memory details" >> $PROD_ENV-monitoring-report.txt
kubectl top node >> $PROD_ENV-monitoring-report.txt
#echo "===========================================================================================================" >> $PROD_ENV-monitoring-report.txt



echo "" >> $PROD_ENV-monitoring-report.txt

echo "ibus-CrashLoopBackOff pods list" >> $PROD_ENV-monitoring-report.txt
#echo "===========================================================================================================" >> $PROD_ENV-monitoring-report.txt
kubectl get po | grep CrashLoopBackOff | cut -d ' ' -f 1 >> $PROD_ENV-monitoring-report.txt
#echo "===========================================================================================================" >> $PROD_ENV-monitoring-report.txt
echo "" >> $PROD_ENV-monitoring-report.txt

#echo "digimops CrashLoopBackOff pods list" >> $PROD_ENV-monitoring-report.txt
#echo "===========================================================================================================" >> $PROD_ENV-monitoring-report.txt
kubectl get po -n digimops | grep CrashLoopBackOff | cut -d ' ' -f 1 >> $PROD_ENV-monitoring-report.txt
#echo "===========================================================================================================" >> $PROD_ENV-monitoring-report.txt
echo "" $PROD_ENV-monitoring-report.txt
echo "ibus-pods" >> $PROD_ENV-monitoring-report.txt
$KC >> $PROD_ENV-monitoring-report.txt
echo "" >> $PROD_ENV-monitoring-report.txt
echo ""
echo "digimops pods" >> $PROD_ENV-monitoring-report.txt
$KC -n digimops >> $PROD_ENV-monitoring-report.txt
echo "" >> $PROD_ENV-monitoring-report.txt
echo "converting to csv"
mv $PROD_ENV-monitoring-report.txt $PROD_ENV-monitoring-report.csv
sed 's/\t/ /g' $PROD_ENV-monitoring-report.csv |sed 's/  */ /g' |sed 's/ /,/g' > $PROD_ENV-monitoring-report-final.csv
echo "********report generated********"
