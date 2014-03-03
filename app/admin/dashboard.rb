ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    #div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #  span :class => "blank_slate" do
    #    span I18n.t("active_admin.dashboard_welcome.welcome")
    #    small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #  end
    #end

    columns do
       column do
         panel "Recent User" do
           ul do
             User.order("created_at desc").limit(5).map do |user|
             #User.recent(5).map do |user|
               li link_to(user.name, admin_user_path(user))
             end
           end
           strong { link_to "View All User", admin_users_path }
         end

         panel "Recent Resource" do
           ul do
             Ebook.order("created_at desc").limit(5).map do |ebook|
               #User.recent(5).map do |user|
               li link_to(ebook.name, admin_ebook_path(ebook))
             end
           end
           strong { link_to "View All Resources", admin_ebooks_path }
         end

         panel "Recent Mentee" do
           ul do
             Mentee.order("created_at desc").limit(5).map do |mentee|
               #User.recent(5).map do |user|
               li link_to(mentee.name, admin_mentee_path(mentee))
             end
           end
           strong { link_to "View All Mentees", admin_mentees_path }
         end

       end

       column do
         panel "Info" do
           para "Welcome to ActiveAdmin."
         end
       end
    end
  end # content
end
