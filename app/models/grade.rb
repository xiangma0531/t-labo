class Grade < ActiveHash::Base
  self.data = [
    { id: 1, name: '幼稚園・保育園', abb_name: '幼・保'}, { id: 2, name: '小学校', abb_name: '小学校'},
    { id: 3, name: '中学校', abb_name: '中学校'}, { id: 4, name: '高等学校', abb_name: '高校'},
    { id: 5, name: '特別支援学校', abb_name: '特支'}, { id: 6, name: '大学', abb_name: '大学'},
    { id: 7, name: 'その他', abb_name: 'その他'}
  ]
  include ActiveHash::Associations
  has_many :sources
  has_many :users
end