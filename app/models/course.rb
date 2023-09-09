class Course < ActiveHash::Base
  self.data = [
    { id: 0, subject_id: 0, name: '科目を選択してください'},
    { id: 1, subject_id: 1, name: '現代文'},
    { id: 2, subject_id: 1, name: '古文'},
    { id: 3, subject_id: 2, name: '数学ⅠA'},
    { id: 4, subject_id: 2, name: '数学ⅡB'},
    { id: 5, subject_id: 2, name: '数学Ⅲ'},
    { id: 6, subject_id: 3, name: '生物・生物基礎'},
    { id: 7, subject_id: 3, name: '物理・物理基礎'},
    { id: 8, subject_id: 3, name: '化学・化学基礎'},
    { id: 9, subject_id: 4, name: '日本史'},
    { id: 10, subject_id: 4, name: '世界史'},
    { id: 11, subject_id: 4, name: '地理'},
    { id: 12, subject_id: 4, name: '現代社会'},
    { id: 13, subject_id: 4, name: '政治・経済'},
    { id: 14, subject_id: 4, name: '倫理'},
    { id: 15, subject_id: 5, name: 'コミュニケーション英語'},
    { id: 16, subject_id: 5, name: '英語表現'},
    { id: 17, subject_id: 6, name: '保健'},
    { id: 18, subject_id: 6, name: '体育'},
    { id: 19, subject_id: 7, name: '音楽'},
    { id: 20, subject_id: 7, name: '美術'},
    { id: 21, subject_id: 7, name: '書道'},
    { id: 22, subject_id: 8, name: '技術'},
    { id: 23, subject_id: 8, name: '家庭科'},
    { id: 24, subject_id: 9, name: '商業'},
    { id: 25, subject_id: 10, name: '工業'},
    { id: 26, subject_id: 11, name: '農業'},
    { id: 27, subject_id: 12, name: '看護'},
    { id: 28, subject_id: 13, name: '総合'},
    { id: 29, subject_id: 14, name: '学級活動・LHR'},
    { id: 30, subject_id: 15, name: 'その他'},

  ]
  include ActiveHash::Associations
  has_many :sources
  belongs_to :users
  belongs_to :subject
end