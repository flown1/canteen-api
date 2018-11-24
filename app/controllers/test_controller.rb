class TestController < ApplicationController
    def hello
        puts "Trying to send OK..."
        render json: {
            data: "Testing controller send back OK"
        }, status: :OK
    end
end
