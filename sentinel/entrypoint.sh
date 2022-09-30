#!/bin/sh

echo ""
echo "== Starting Redis Sentinel =="
echo ""

CONFIG_DIR=/etc/redis

# master
echo ">> update redis master config file"
ORIGINAL_MASTER_CONFIG_FILE="${CONFIG_DIR}/master.conf"
MASTER_CONFIG_FILE="${WORK_DIR}/master.conf"
MASTER_DAEMONIZE=no
cp ${ORIGINAL_MASTER_CONFIG_FILE} ${MASTER_CONFIG_FILE}
sed -i "s|\$REDIS_PASSWORD|${REDIS_PASSWORD}|g" ${MASTER_CONFIG_FILE}
sed -i "s|\$MASTER_PORT|${MASTER_PORT}|g" ${MASTER_CONFIG_FILE}
sed -i "s|\$WORK_DIR|${WORK_DIR}|g" ${MASTER_CONFIG_FILE}
sed -i "s|\$MASTER_DAEMONIZE|${MASTER_DAEMONIZE}|g" ${MASTER_CONFIG_FILE}
echo "====================[ ${MASTER_CONFIG_FILE} ]===================="
cat ${MASTER_CONFIG_FILE}
echo "======================================================================"
echo ""

# slaves
for ID in 1 2
do
    echo ">> update redis slave${ID} config file"
    ORIGINAL_SLAVE_CONFIG_FILE="${CONFIG_DIR}/slave${ID}.conf"
    SLAVE_CONFIG_FILE="${WORK_DIR}/slave${ID}.conf"
    cp ${ORIGINAL_SLAVE_CONFIG_FILE} ${SLAVE_CONFIG_FILE}
    SLAVE_PORT=$(echo ${SLAVES_PORT} | cut -f${ID} -d'|')
    SLAVE_DAEMONIZE=no
    sed -i "s|\$REDIS_PASSWORD|${REDIS_PASSWORD}|g" ${SLAVE_CONFIG_FILE}
    sed -i "s|\$SLAVE_IP|${LOCAL_HOST}|g" ${SLAVE_CONFIG_FILE}
    sed -i "s|\$SLAVE_PORT|${SLAVE_PORT}|g" ${SLAVE_CONFIG_FILE}
    sed -i "s|\$WORK_DIR|${WORK_DIR}|g" ${SLAVE_CONFIG_FILE}
    sed -i "s|\$MASTER_IP|${LOCAL_HOST}|g" ${SLAVE_CONFIG_FILE}
    sed -i "s|\$MASTER_PORT|${MASTER_PORT}|g" ${SLAVE_CONFIG_FILE}
    sed -i "s|\$SLAVE_DAEMONIZE|${SLAVE_DAEMONIZE}|g" ${SLAVE_CONFIG_FILE}
    echo "====================[ ${SLAVE_CONFIG_FILE} ]===================="
    cat ${SLAVE_CONFIG_FILE}
    echo "======================================================================"
    echo ""
done

# sentinels
for ID in 1 2 3
do
    echo ">> update redis sentinel${ID} config file"
    ORIGINAL_SENTINEL_CONFIG_FILE="${CONFIG_DIR}/sentinel${ID}.conf"
    SENTINEL_CONFIG_FILE="${WORK_DIR}/sentinel${ID}.conf"
    SENTINEL_PORT=$(echo ${SENTINELS_PORT} | cut -f${ID} -d'|')
    SENTINEL_DAEMONIZE=no
    cp ${ORIGINAL_SENTINEL_CONFIG_FILE} ${SENTINEL_CONFIG_FILE}
    sed -i "s|\$REDIS_PASSWORD|${REDIS_PASSWORD}|g" ${SENTINEL_CONFIG_FILE}
    sed -i "s|\$SENTINEL_IP|${LOCAL_HOST}|g" ${SENTINEL_CONFIG_FILE}
    sed -i "s|\$SENTINEL_PORT|${SENTINEL_PORT}|g" ${SENTINEL_CONFIG_FILE}
    sed -i "s|\$SENTINEL_DAEMONIZE|${SENTINEL_DAEMONIZE}|g" ${SENTINEL_CONFIG_FILE}
    sed -i "s|\$WORK_DIR|${WORK_DIR}|g" ${SENTINEL_CONFIG_FILE}
    sed -i "s|\$MASTER_NAME|${MASTER_NAME}|g" ${SENTINEL_CONFIG_FILE}
    sed -i "s|\$MASTER_IP|${LOCAL_HOST}|g" ${SENTINEL_CONFIG_FILE}
    sed -i "s|\$MASTER_PORT|${MASTER_PORT}|g" ${SENTINEL_CONFIG_FILE}
    sed -i "s|\$SENTINEL_QUORUM|${SENTINEL_QUORUM}|g" ${SENTINEL_CONFIG_FILE}
    sed -i "s|\$SENTINEL_DOWN_AFTER_MILLISECONDS|${SENTINEL_DOWN_AFTER_MILLISECONDS}|g" ${SENTINEL_CONFIG_FILE}
    sed -i "s|\$SENTINEL_NUMBER_PARALEL_SYNCS_SLAVES|${SENTINEL_NUMBER_PARALEL_SYNCS_SLAVES}|g" ${SENTINEL_CONFIG_FILE}
    sed -i "s|\$SENTINEL_FAILOVER_TIMEOUT_MILLISECONDS|${SENTINEL_FAILOVER_TIMEOUT_MILLISECONDS}|g" ${SENTINEL_CONFIG_FILE}
    echo "====================[ ${SENTINEL_CONFIG_FILE} ]===================="
    cat ${SENTINEL_CONFIG_FILE}
    echo "======================================================================"
    echo ""
done

# supervisord
echo ">> update supervisord config file"
ORIGINAL_SUPERVISORD_CONFIG_FILE="${CONFIG_DIR}/supervisord.conf"
SUPERVISORD_CONFIG_FILE="${WORK_DIR}/supervisord.conf"
cp ${ORIGINAL_SUPERVISORD_CONFIG_FILE} ${SUPERVISORD_CONFIG_FILE}
sed -i "s|\$MASTER_CONFIG_FILE|${MASTER_CONFIG_FILE}|g" ${SUPERVISORD_CONFIG_FILE}
for ID in 1 2
do
    SLAVE_CONFIG_FILE="${WORK_DIR}/slave${ID}.conf"
    sed -i "s|\$SLAVE${ID}_CONFIG_FILE|${SLAVE_CONFIG_FILE}|g" ${SUPERVISORD_CONFIG_FILE}
done
for ID in 1 2 3
do
    SENTINEL_CONFIG_FILE="${WORK_DIR}/sentinel${ID}.conf"
    sed -i "s|\$SENTINEL${ID}_CONFIG_FILE|${SENTINEL_CONFIG_FILE}|g" ${SUPERVISORD_CONFIG_FILE}
done
echo "====================[ ${SUPERVISORD_CONFIG_FILE} ]===================="
cat ${SUPERVISORD_CONFIG_FILE}
echo "======================================================================"
echo ""

# start
echo ">> run supervisord"
exec docker-entrypoint.sh supervisord -c ${SUPERVISORD_CONFIG_FILE}
