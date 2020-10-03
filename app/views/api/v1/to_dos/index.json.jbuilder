json.array! @to_dos do |to_do| # array!メソッドでJSONを配列に入れて返す
    # Vue.jsにToDoのidを渡す
    json.id to_do.id 
    json.title to_do.title
    json.expired_at to_do.expired_at&.to_s
    # [{"title": "to_do.title1", "expired_at": "to_do.expired_at1"}, {"title": "to_do.title2", "expired_at": "to_do.expired_at2"}]
end