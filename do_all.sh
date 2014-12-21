#!/bin/bash
#========================================================================
#   FileName: do_all.sh
#     Author: shimmeryang && kevinlin
#      Desc:  ��������֮ͳһ�ű�
#   History:
#   2013��11��8�� 14:05:17 kevin �Ű���һ�´��ļ��������һЩע�ͣ�����ȥ���˲�Ӧ�����ɵġ����ڵ�����
# LastChange: 2013-11-08 14:04:50
#   2013��11��13�� 21:26:11 shimmeryang ���һ����lua�����ļ����м��Ĺ���do_test.lua���Ժ��lua�ļ����򶼿��Էŵ�����
#   2013��11��13�� 22:16:42 shimmeryang ��Ӱ汾��Ϣ���ƣ��ѽű����ɺ�����ʽ������������һ��
#   2014��12��15�� 13:33:59 kevin  Ĭ��ʹ��������ʽ��������, ��������ñ���󵼳��ٶ�
#========================================================================
#�汾��Ϣ�ļ�
version_file=excel_version.txt
version_lua_template=output/config_version.lua.in
version_lua=output/config_version.lua

LOCK_FILE=lockfile.tmp

#ֻ����ͬʱһ��ʵ��ִ�� @kevin
if [ -e ${LOCK_FILE} ] ; then
    echo "��Ǹ������������ִ���������ɣ����Ժ����ԡ���һֱ���ɹ�����ɧ������~~"
    exit 0
else
    touch ${LOCK_FILE}
    chmod 600 ${LOCK_FILE}
fi
trap "rm -f ${LOCK_FILE}; exit"  0 1 2 3 9 15


just_do () {
    #-------------------------------------------------------------------------------------
    #2014��12��15�� 13:25:51 @kevin ʹ�������ű�����������
    ./rapid_do.sh
	return 0
}

copy_to_svr_dir() {
    #-----------------------������ͳһ�������һ����������޸�--------------------------
    #NOTE: ���Ҫ��Ӷ�������������ӣ�û�²�Ҫ�޸�����Ķ���
    #TODO ��������
    #[ $? -eq 0 ]

    #�����ÿ������ͻ���Ŀ¼
    cp -vf output/config_client*.lua lua

    #�����ÿ�����zonesvr/luaȥ
    cp -vf output/config_svr*.lua ../zonesvr/lua/

    #������gamesvr�Ķ���
    cp -vf output/config_svr_dungeon_list.lua ../gamesvr/lua/
    cp -vf output/config_svr_card_list.lua ../gamesvr/lua/
    cp -vf output/config_svr_card_evo_ratio.lua ../gamesvr/lua/
    cp -vf output/config_svr_gem_info_list.lua ../gamesvr/lua/
    cp -vf output/config_svr_weapon_list.lua ../gamesvr/lua/
    cp -vf output/config_svr_weapon_promote_list.lua ../gamesvr/lua/
    cp -vf output/config_svr_weapon_suit_list.lua ../gamesvr/lua/
    cp -vf output/config_svr_weapon_enhance_base.lua ../gamesvr/lua/
    cp -vf output/config_svr_weapon_level_ratio.lua ../gamesvr/lua/
    cp -vf output/config_svr_weapon_refine_list.lua ../gamesvr/lua/
    cp -vf output/config_svr_weapon_atk_ratio.lua ../gamesvr/lua/
    cp -vf output/config_svr_weapon_dfn_ratio.lua ../gamesvr/lua/
    cp -vf output/config_svr_treasure_promote_list.lua ../gamesvr/lua/
    cp -vf output/config_svr_rune_promote_list.lua ../gamesvr/lua/
    cp -vf output/config_svr_fate_list.lua ../gamesvr/lua/
    cp -vf output/config_svr_fate_detail_list.lua ../gamesvr/lua/
    cp -vf output/config_svr_mjbattle.lua ../gamesvr/lua/
    cp -vf output/config_svr_mjteam.lua ../gamesvr/lua/
    cp -vf output/config_svr_adv_activity_list.lua  ../ywtsvr/lua/
    cp -vf output/config_svr_tower_act_rank_reward.lua ../ywtsvr/lua/
    cp -vf output/config_svr_huntianzhen_rank_reward.lua ../ywtsvr/lua/
    cp -vf output/config_svr_card_lv_hp_ratio.lua ../gamesvr/lua/
    cp -vf output/config_svr_card_lv_atk_ratio.lua ../gamesvr/lua/
    cp -vf output/config_svr_bible_info.lua ../gamesvr/lua/


	#�����ٱ�ϵͳ���������
	cp -vf output/config_svr_global_conf.lua ../rob_svr/lua/
	cp -vf output/config_svr_card_list.lua ../rob_svr/lua/
	cp -vf output/config_svr_rob_rc.lua ../rob_svr/lua/

    #guildsvrʹ��
	cp -vf output/config_svr_guild*.lua ../guildsvr/lua/
    cp -vf output/config_svr_zone_info.lua  ../guildsvr/lua/

    cp -vf output/config_svr_zone_info.lua  ../tcm_cfg/lua/
    cp -vf output/config_svr_zone_info.lua  ../dir/lua/

	#������guildsvr
    cp -vf output/config_svr_global_conf.lua ../guildsvr/lua/
    cp -vf output/config_svr_guild_player_info.lua ../zonesvr/lua/

    #����ȫ�����õ���Ծ��ҷ�����
	cp -vf output/config_svr_global_conf.lua ../active_player/lua/

    #����һЩ��Ҫ�ļ���idipsvrȥ
    cp -vf output/config_svr_goods_info.lua ../idipsvr/lua/
    cp -vf output/DataConfigSvr.lua ../idipsvr/lua/
    # 2014��04��04�� 11:46:10/shimmeryang ��������ļ����������ˣ��ǲ��ǿ���ȥ����
    #cp -vf output/GemInfoSvr.lua ../idipsvr/lua/
    cp -vf output/config_svr_card_list.lua ../idipsvr/lua/
    cp -vf output/config_svr_card_evo_ratio.lua ../idipsvr/lua/

    #���������ļ���matchsvr��ʹ��
    cp -vf output/config_svr_mineral_info.lua ../matchsvr/lua/
    cp -vf output/DataConfigSvr.lua ../matchsvr/lua/
    cp -vf output/config_svr_card_list.lua ../matchsvr/lua/
}

#---------------------------------------------------------------------------------
svn_update() {
    svn up
}

#--------------------------------------------------------------------------------------
lua_commit() {
    svn ci -m "commit lua config for client" lua
    # this config_version.lua can not commit, so we add one more line for this file to commit
    svn ci -m "commit config_version.lua again" lua/config_version.lua
    return 0
}

#-----------------------�����ɵ�lua�����һЩ���--------------------------
lua_test() {
    lua do_test.lua
    return 0
}

#------------- �����all_xls_version.*�ļ����ļ�����������ʱ��ȫ��������������һ��----
clean_xls_version() {
    rm all_xls_version.*
}

#����һ���汾����
version_check() {
    old_excel_version=0
    [ -f ${version_file} ] && old_excel_version=`cat ${version_file}`
    excel_version=`svn log  -l 1 excel | egrep '^r[0-9]*' | head -n 1| awk '{print $1}'`

    if [ ${old_excel_version} = ${excel_version} ]; then
        echo "excels had no change, just exit!"
        exit 0
    fi

    return 0
}

version_write() {
    excel_version=`svn log  -l 1 excel | egrep '^r[0-9]*' | awk '{print $1}'`
    sed "s|#VERSION_NUM#|${excel_version}|g" ${version_lua_template} > ${version_lua}
    echo $excel_version > ${version_file}
    return 0
}

version_copy() {
    cp -vf ${version_lua} lua && cp -vf ${version_lua} ../zonesvr/lua/

    return 0
}

backup() {
    server_lua=server_lua
    date=`date "+%Y%m%d"`
    publish=$server_lua/publish_$date
    echo "mkdir $publish"
    mkdir -p $publish
    echo "copy server lua to $publish"
    cp -f output/ErrorCode.lua $publish
    cp output/*Svr.lua $publish
    cp output/config_svr_* $publish
    echo "svn commit new publish server lua"
    svn add $publish
    svn ci -m "backup publish server lua" $publish
    pre_publish=`ls -l $server_lua | tail -n 2 | head -n 1 | awk '{print $NF}'`
    #diff -cN $publish $server_lua/$pre_publish > $server_lua/$date.diff
    diff -E -b -w -t -T -N  -y  -W 150 $publish $server_lua/$pre_publish > $server_lua/$date.diff
    svn add $server_lua/$date.diff
    svn ci -m "add diff file" $server_lua/$date.diff
}

case "$1" in
    do)
        #version_check
        just_do
        copy_to_svr_dir
        version_write
        version_copy
        lua_test
        lua_commit
        RETVAL=$?
    ;;
    full_do)
        svn_update
        clean_xls_version
        just_do
        copy_to_svr_dir
        version_write
        version_copy
        lua_test
        lua_commit
        RETVAL=$?
    ;;
    update_do)
        svn_update
        #version_check
        just_do
        copy_to_svr_dir
        version_write
        version_copy
        lua_test
        lua_commit
        RETVAL=$?
    ;;
    just_do)
        just_do
        copy_to_svr_dir
        version_write
        version_copy
        lua_test
        #lua_commit
        RETVAL=$?
    ;;
    commit)
        lua_commit
        RETVAL=$?
        ;;
    test)
        lua_test
        RETVAL=$?
        ;;
    only_do)
        just_do
        copy_to_svr_dir
        lua_test
        RETVAL=$?
        ;;
    backup)
        backup
        ;;
    *)
        echo $"Usage: $0 {do|just_do|full_do|commit|test|only_do}"
        echo $"do: with version check and commit"
        echo $"just_do: just do with no version check"
        echo $"full_do: clean all and create all config from excel"
        echo $"commit: commit lua/* to svn"
        echo $"test: check lua config validation"
        echo $"only_do: only do, do not do any other thing"
        echo $"update_do: exec svn update before do"
        echo $"backup: backup svr config and make a diff"
esac

exit $RETVAL

