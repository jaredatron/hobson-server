module Hobson::Server::Helpers

  def project_origin_url project_origin
    host, path = project_origin.scan(/(?:https?:\/\/)?(?:.*@)?(.+?)[:\/]+(.+?)(?:\.git)?$/).first
    "http://#{host}/#{path}"
  end

  def test_run_sha_link test_run
    url = "#{project_origin_url(test_run.project_origin)}/commit/#{test_run.sha}"
    link_to(test_run.sha, url)
  end

  def project_origin_link origin
    link_to(origin, project_origin_url(origin))
  end

  def link_to content, href, options={}, &block
    options[:href] = href
    haml_tag(:a, content, options, &block)
  end

  def delete_link content, action
    haml_tag(:form, :action => action, :method => 'post') do
      haml_tag(:input, :type => :hidden, :name => '_method', :value => 'delete')
      haml_tag(:a, content, :href => "", :onclick => <<-JS)
        if (confirm('are you sure?')) $(this).parent().submit(); return false;
      JS
    end
  end

end
