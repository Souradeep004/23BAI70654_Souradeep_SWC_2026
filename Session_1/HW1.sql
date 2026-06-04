-- Stratascratch 10285

select fb_1.date, round(
        count(fb_2.action) / cast(count(fb_1.action) as decimal), 2
    ) as acceptance_rate
from
    fb_friend_requests fb_1
    LEFT JOIN fb_friend_requests fb_2 ON fb_1.action != fb_2.action
    and fb_1.user_id_sender = fb_2.user_id_sender
    and fb_1.user_id_receiver = fb_2.user_id_receiver
where
    fb_1.action = 'sent'
group by
    fb_1.date;