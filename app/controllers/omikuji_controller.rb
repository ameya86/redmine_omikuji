class OmikujiController < ApplicationController
  before_filter :find_project_by_project_id

  # ランダムに担当者に割り当てる
  def draw
    # 未完了で担当の無いのチケット
    open_issues = @project.issues.open.where(['assigned_to_id is null'])

    # 対象チケットが無い場合は、一覧に戻る
    if open_issues.empty?
      flash[:warning] = l(:text_omikuji_issue_not_found)
      redirect_to :controller => 'issues', :action => 'index', :project_id => @project
      return
    end

    # ランダムな要素の担当者として設定する
    issue_count = open_issues.length
    rand_index = rand(issue_count)

    issue = open_issues[rand_index]
    issue.assigned_to = User.current

    if issue.save # 割り当て成功
      flash[:notice] = l(:text_omikuji_set_issue)
      # 割り当てたチケットを表示する
      redirect_to :controller => 'issues', :action => 'show', :id => issue.id
      return
    end

    # 保存失敗
    redirect_to :controller => 'issues', :action => 'index', :project_id => @project
  end
end
