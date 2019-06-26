function run(msg, matches)
    if string.lower(matches[1]) == 'clean' and is_mod(msg) then
        function delHistory(data,org)
            tdbot.getChatMember(msg.chat_id,our_id,function(arg,input)
                if input.status.can_delete_messages then
                    if org.messages and #org.messages > 0 then
                        for k,v in pairs(org.messages) do
                            tdbot.deleteMessagesFromUser(data.chat_id,v.sender_user_id)
                        end
                        tdbot.getChatHistory(data.chat_id,data.msg_id,0,200, 0,delHistory,{chat_id=data.chat_id,msg_id=data.msg_id})
                    else
                        tdbot.sendText(data.chat_id,0,'پاکسازی پایان یافت !', 0, 1, nil, 1, 'md')
                    end
                else
                    tdbot.sendText(data.chat_id,msg.id,'دسترسی برای حذف پیام ندارم !', 0, 1, nil, 1, 'md')
                end
            end)
        end
        tdbot.getChatHistory(msg.chat_id,msg.id, 0,200,0,delHistory,{chat_id=msg.chat_id,msg_id=msg.id})
    end
end
return {
    patterns = {
        "^[!/#](clean)$"
    },
    run = run
}
