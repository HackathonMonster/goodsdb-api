json.partial! 'users/user', user: @user,
                            include_votes: true, include_records: true,
                            include_authorization: @include_authorization
