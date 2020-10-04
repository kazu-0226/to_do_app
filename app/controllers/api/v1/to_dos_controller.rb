class Api::V1::ToDosController < ActionController::API
# ActionController::APIを継承することによって、このToDoコントローラをAPI用に
    def index
        @to_dos = ToDo.all
        #to_dosのJSONを返す
        # render json: to_dos
    end

    def create
        @to_do = ToDo.new(to_do_params)
        if @to_do.save
          render status: :created
        else
          render status: 400, json: { status: 400, message: 'ToDoの作成に失敗しました' }
        end
    end

    def update
        @to_do = ToDo.find_by(id: params[:id])
        if @to_do.update(to_do_params)
            render status: 200, json: { status: 200 }
        end
    end

    def destroy
        to_do = ToDo.find_by(id: params[:id])
        if to_do.destroy
            # HTTPステータスコードの200をレスポンス（JSON含む）として設定
            render status: 200, json: { status: 200 }
        end
    end

    private

    def to_do_params
    params.require(:to_do).permit(:title, :expired_at, :finished)
    end

end
