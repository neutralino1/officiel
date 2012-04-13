module ApplicationHelper
  def oddity(n)
    n.odd? ? 'odd' : 'even'
  end
end
