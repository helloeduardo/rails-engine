class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.single_search(attribute, value)
    if attribute == 'created_at' || attribute == 'updated_at'
      find_by("DATE(#{attribute}) = '%#{value.to_date}%'")
    elsif attribute == 'unit_price'
      find_by(unit_price: value.to_f)
    else
      find_by("LOWER(#{attribute}) LIKE ?", "%#{value.downcase}%")
    end
  end

  def self.multi_search(attribute, value)
    if attribute == 'created_at' || attribute == 'updated_at'
      where("DATE(#{attribute}) = '%#{value.to_date}%'")
    elsif attribute == 'unit_price'
      where(unit_price: value.to_f)
    else
      where("LOWER(#{attribute}) LIKE ?", "%#{value.downcase}%")
    end
  end
end
