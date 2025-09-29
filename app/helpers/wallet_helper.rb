module WalletHelper
  def find_walletable
    walletable_type = params[:walletable_type]
    walletable_id = params[:walletable_id]

    @walletable = find_target_entity(walletable_type, walletable_id)
    render_error("Wallet not found", :not_found) unless @walletable
  end

  def find_target_entity(type, id)
    case type.downcase
    when 'user'
      User.find_by(id:)
    else
      raise ArgumentError, "Invalid walletable type: #{type}"
    end
  end
end
