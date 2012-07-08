module Assert
  def assert value, message=nil
    (!!value).should be_true, message
  end
end
