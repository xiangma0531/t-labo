class Subject < ActiveHash::Base
  self.data = [
    # { id: 0, name: '教科を選択してください'},
    { id: 1, name: '国語'},
    { id: 2, name: '算数・数学'},
    { id: 3, name: '理科'},
    { id: 4, name: '社会'},
    { id: 5, name: '外国語'},
    { id: 6, name: '保健体育'},
    { id: 7, name: '芸術'},
    { id: 8, name: '技術・家庭'},
    { id: 9, name: '商業'},
    { id: 10, name: '工業'},
    { id: 11, name: '農業'},
    { id: 12, name: '看護'},
    { id: 13, name: '総合'},
    { id: 14, name: '学級活動'},
    { id: 15, name: 'その他'}
  ]
  include ActiveHash::Associations
  has_many :sources
  belongs_to :users
  has_many :courses
end