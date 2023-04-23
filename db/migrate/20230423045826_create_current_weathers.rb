class CreateCurrentWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :current_weathers do |t|
      t.string 'last_updated'
      t.float 'temperature'
      t.float 'feels_like'
      t.float 'humidity'
      t.float 'uvi'
      t.float 'visibility'
      t.string 'condition'
      t.string 'icon'
      t.timestamps
    end
  end
end
