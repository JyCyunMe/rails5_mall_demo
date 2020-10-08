module RenderingHelper
  extend ActiveSupport::Concern

  private
    # 刷新通过 Ajax 调用方法的当前页面
    def render_turbolinks_reload
      render js: 'Turbolinks.reload()'
    end

    def render_ajax_success(data = {})
      render json: data.merge(success: true)
    end

    def render_ajax_failure(data = {})
      render json: data.merge(success: false)
    end

end