require 'elasticsearch/model'

class Word < ApplicationRecord
     # full text search
    
     include Elasticsearch::Model
     include Elasticsearch::Model::Callbacks

    has_and_belongs_to_many :lessons
    has_many :studies, dependent: :destroy
    
    validates :word, presence: true, length: { maximum:50}
    validates :meaning, presence: true
    mount_uploader :picture, PictureUploader

    scope :filterOrder, -> (sort) { order('word '+sort) }
    scope :filterType, -> (type) { 
        where(course_category_id: type.to_i) unless type =="0" 
    }
    scope :filterStateWord, -> (stateWord,current_user_id) {
        unless stateWord=="0"
            @word_ids = Study.where(user_id: current_user_id).pluck(:word_id).map(&:to_i)
            if stateWord=="1"
                where(id:@word_ids)
            elsif stateWord=="2"
                where.not(id:@word_ids)
            end
        end
    }

    def self.search(query)
        __elasticsearch__.search(
          {
            query: {
              multi_match: {
                query: query,
                fields: [:word]
              }
            },
            highlight: {
              pre_tags: ['<em>'],
              post_tags: ['</em>'],
              fields: {
                word: {}
              }
            }
          }
        )
      end

end