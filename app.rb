require 'sinatra'
require 'json'

set :bind, '0.0.0.0'
set :port, 9495

before do
	@twitter_response = JSON.parse('{
		"created_at": "Tue Aug 28 00:59:49 +0000 2012",
		"entities": {
			"hashtags": [],
			"urls": [],
			"user_mentions": []
			},
			"id": 240252311455277056,
			"id_str": "240252311455277056",
			"recipient": {
				"contributors_enabled": true,
				"created_at": "Sat May 09 17:58:22 +0000 2009",
				"default_profile": false,
				"default_profile_image": false,
				"description": "I taught your phone that thing you like.  The Mobile Partner Engineer @Twitter. ",
				"favourites_count": 584,
				"follow_request_sent": false,
				"followers_count": 10622,
				"following": true,
				"friends_count": 1181,
				"geo_enabled": true,
				"id": 38895958,
				"id_str": "38895958",
				"is_translator": false,
				"lang": "en",
				"listed_count": 190,
				"location": "San Francisco",
				"name": "Sean Cook",
				"notifications": false,
				"profile_background_color": "1A1B1F",
				"profile_background_image_url": "http://a0.twimg.com/profile_background_images/495742332/purty_wood.png",
				"profile_background_image_url_https": "https://si0.twimg.com/profile_background_images/495742332/purty_wood.png",
				"profile_background_tile": true,
				"profile_image_url": "http://a0.twimg.com/profile_images/1751506047/dead_sexy_normal.JPG",
				"profile_image_url_https": "https://si0.twimg.com/profile_images/1751506047/dead_sexy_normal.JPG",
				"profile_link_color": "2FC2EF",
				"profile_sidebar_border_color": "181A1E",
				"profile_sidebar_fill_color": "252429",
				"profile_text_color": "666666",
				"profile_use_background_image": true,
				"protected": false,
				"screen_name": "theSeanCook",
				"show_all_inline_media": true,
				"statuses_count": 2608,
				"time_zone": "Pacific Time (US & Canada)",
				"url": null,
				"utc_offset": -28800,
				"verified": false
				},
				"recipient_id": 38895958,
				"recipient_screen_name": "theSeanCook",
				"sender": {
					"contributors_enabled": false,
					"created_at": "Thu Aug 23 19:45:07 +0000 2012",
					"default_profile": false,
					"default_profile_image": false,
					"description": "Keep calm and test",
					"favourites_count": 0,
					"follow_request_sent": false,
					"followers_count": 0,
					"following": false,
					"friends_count": 11,
					"geo_enabled": true,
					"id": 776627022,
					"id_str": "776627022",
					"is_translator": false,
					"lang": "en",
					"listed_count": 0,
					"location": "San Francisco, CA",
					"name": "Mick Jagger",
					"notifications": false,
					"profile_background_color": "000000",
					"profile_background_image_url": "http://a0.twimg.com/profile_background_images/644522235/cdjlccey99gy36j3em67.jpeg",
					"profile_background_image_url_https": "https://si0.twimg.com/profile_background_images/644522235/cdjlccey99gy36j3em67.jpeg",
					"profile_background_tile": true,
					"profile_image_url": "http://a0.twimg.com/profile_images/2550256790/hv5rtkvistn50nvcuydl_normal.jpeg",
					"profile_image_url_https": "https://si0.twimg.com/profile_images/2550256790/hv5rtkvistn50nvcuydl_normal.jpeg",
					"profile_link_color": "000000",
					"profile_sidebar_border_color": "000000",
					"profile_sidebar_fill_color": "000000",
					"profile_text_color": "000000",
					"profile_use_background_image": false,
					"protected": false,
					"screen_name": "s0c1alm3dia",
					"show_all_inline_media": false,
					"statuses_count": 0,
					"time_zone": "Pacific Time (US & Canada)",
					"url": "http://cnn.com",
					"utc_offset": -28800,
					"verified": false
					},
					"sender_id": 776627022,
					"sender_screen_name": "s0c1alm3dia",
					"text": "hello, tworld. welcome to 1.1."
					}')

end
post '/1.1/direct_messages/new.json' do
	if params['text'].nil?
		return '{"errors":[{"code":38,"message":"Text parameter is missing."}]}'
	end
	if params['screen_name'].nil? && params['user_id'].nil?
		return '{"errors":[{"code":38,"message":"Recipient (user, screen name, or id) parameter is missing."}]}'
	end
	if params['text'].length > 140
		return '{"errors":[{"code":354,"message":"The text of your direct message is over the max character limit."}]}'
	end
	@twitter_response['created_at'] = Time.now
	@twitter_response['text'] = params['text']
	@twitter_response['recipient_screen_name'] = params['screen_name']
	@twitter_response['sender_screen_name'] = params['screen_name']
	@twitter_response['recipient_id'] ||= params['user_id']
	File.open("/messages/" + "request_" + DateTime.now.strftime('%Q') + ".json", 'w') {|f| f.write(params.to_json) }
	File.open("/messages/" + "response_" + DateTime.now.strftime('%Q') + ".json", 'w') {|f| f.write(@twitter_response.to_json) }
	@twitter_response.to_json
end
