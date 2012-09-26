class Service::Beeminder < Service
    def receive_push
      http_post \
        "https://www.beeminder.com/api/v1/users/%s/goals/%g/datapoints.json?auth_token=%s" %
            [
              secrets['beeminder']['user'],
              secrets['beeminder']['goal'],
              secrets['beeminder']['apikey']
            ],
        :payload => JSON.generate(payload)
    end
end
