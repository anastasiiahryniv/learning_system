module DownloadablePdf
  extend ActiveSupport::Concern

  def download_pdf
    user = pundit_user
    pdf = Prawn::Document.new

    pdf.text "User Profile", size: 24, style: :bold, align: :center
    pdf.move_down 20

    if user&.avatar&.attached?
      image = StringIO.open(user.avatar.download)
      pdf.image image, fit: [150, 150], position: :center
      pdf.move_down 20
    end

    pdf.font_size(14)
    pdf.text "Name:", style: :bold
    pdf.text user.name
    pdf.move_down 10

    pdf.font_size(14)
    pdf.text "Surname:", style: :bold
    pdf.text user.surname
    pdf.move_down 10

    pdf.text "Email:", style: :bold
    pdf.text user.email
    pdf.move_down 10

    pdf.text "Profile created on:", style: :bold
    pdf.text user.created_at.strftime("%B %d, %Y")

    send_data(pdf.render,
              filename: "#{user.name}_profile.pdf",
              type: "application/pdf")
  end
end
