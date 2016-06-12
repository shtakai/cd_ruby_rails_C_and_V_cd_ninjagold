class RpgController < ApplicationController
  def index
    session[:ninja_gold] ||= init_ninja_gold

  end

  def farm
    update_ninja_gold 'farm', rand(10..20)
    redirect_to rpg_index_path
  end

  def cave
    update_ninja_gold 'cave', rand(5..10)
    redirect_to rpg_index_path
  end

  def casino
    update_ninja_gold 'casino', rand(-50..50)
    redirect_to rpg_index_path
  end

  def house
    update_ninja_gold 'home', rand(2..5)
    redirect_to rpg_index_path
  end

  private

  def init_ninja_gold
    {
      gold: 0,
      activities: []
    }
  end

  def update_ninja_gold(name, gold)
    return if name.blank? || gold.blank?
    session[:ninja_gold][:gold] += gold
    if gold >= 0
      session[:ninja_gold][:activities] << {
        class: 'text-success',
        activity:
          "Earned #{view_context.pluralize(gold, 'gold')} from the #{name}!" << Time.now.strftime('%Y/%m/%d%l:%M %p')
      }
    elsif gold < 0
      session[:ninja_gold][:activities] << {
         class: 'text-danger',
         activity:
          "Entered a #{name} and lost #{view_context.pluralize(gold.abs, 'gold')}... Ouch" << Time.now.strftime('%Y/%m/%d%l:%M %p')
      }
    end
  end

end
