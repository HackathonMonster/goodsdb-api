module SpecHelpers
  module Dummy
    def dummy_date(from = Time.new(1950, 1, 1), to = Time.new(1995, 1, 1))
      Time.at(from + rand * (to.to_f - from.to_f))
    end

    def stub_facebook
      allow_any_instance_of(Koala::Facebook::API).to receive(:get_object)
        .with('me').and_return(user_profile)
    end

    def user_profile
      {
        'id'         => 'user_id',
        'email'      => 'user_email',
        'first_name' => 'user_first_name',
        'last_name'  => 'user_last_name',
        'name'       => 'user_name'
      }
    end
  end
end
