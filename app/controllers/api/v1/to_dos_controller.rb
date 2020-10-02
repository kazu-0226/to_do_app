class Api::V1::ToDosController < ActionController::API
# ActionController::APIを継承することによって、このToDoコントローラをAPI用に
    def index
        @to_dos = ToDo.all
        #to_dosのJSONを返す
        # render json: to_dos
    end


end
