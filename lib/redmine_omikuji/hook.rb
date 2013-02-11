module RedmineOmikuji
  class Hook < Redmine::Hook::ViewListener
    render_on :view_issues_sidebar_planning_bottom,
              :partial => 'omikuji/issues_sidebar_planning_bottom'
  end
end
