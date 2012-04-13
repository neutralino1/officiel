class HomeController < ApplicationController
  def index
    @your_actions = []
    @others_actions = []
    Action.all(:limit => 20, :order => 'updated_at DESC').each do |a|
      if a.page
        if a.user == current_user
          @your_actions << a
        elsif current_user.can_view?(a.page)
          @others_actions << a
        end
      end
    end

    @your_docs = current_user.pages
    @others_docs = []
    Page.all(:limit => 20, :order => 'updated_at DESC').each do |d|
      if not current_user.owns?(d) and current_user.can_view?(d)
        @other_docs << d
      end
    end
  end

end
