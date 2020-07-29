json.words do
  json.array!(@words) do |word|
    json.word word.word
    json.meaning word.meaning
  end
end