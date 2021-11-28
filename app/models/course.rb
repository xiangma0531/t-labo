class Course < ActiveHash::Base
  self.data = [
    { id: 1, name: '現代文'}, { id: 2, name: '古文'},
    { id: 3, name: '数学ⅠA'}, { id: 4, name: '数学ⅡB'},
    { id: 5, name: '数学Ⅲ'}, { id: 6, name: '生物・生物基礎'},
    { id: 7, name: '物理・物理基礎'},{ id: 8, name: '化学・化学基礎'},
    { id: 9, name: '日本史'},{ id: 10, name: '世界史'},
    { id: 11, name: '地理'},{ id: 12, name: '現代社会'},
    { id: 13, name: '政治・経済'},{ id: 14, name: '倫理'},
    { id: 15, name: 'コミュニケーション英語'},{ id: 16, name: '英語表現'},
    { id: 17, name: '保健'},{ id: 18, name: '体育'},
    { id: 19, name: '音楽'},{ id: 20, name: '美術'},
    { id: 21, name: '書道'},{ id: 22, name: '技術'},
    { id: 23, name: '家庭科'},{ id: 24, name: '商業'},
    { id: 25, name: '工業'},{ id: 26, name: '農業'},
    { id: 27, name: '看護'},{ id: 28, name: '総合'},
    { id: 29, name: '学級活動・LHR'},{ id: 30, name: 'その他'},
  ]
  include ActiveHash::Associations
  has_many :sources
  has_many :users
end