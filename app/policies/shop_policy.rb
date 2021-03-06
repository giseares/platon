class ShopPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:products).distinct
    end
  end
  def index?
    return true
  end

  def show?
   true
  end

  def new?
    user.owner?
  end
  
  def create?
    new?
  end

  def update?
    record.user == user
    # - record: the restaurant passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

  def destroy?
    user == record.user #pregunta si el usuario que esta intentando deletear es el mismo usuario que creo el shop
  end
end
