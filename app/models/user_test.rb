class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(
        username: "admin",
        email: "admin@boundlessDrop.com",
        first_name: "Ali",
        last_name: "Dwairi",
        password: "33339999"
    )
  end

  test "should be valid" do
    assert @user.valid?
  end
end