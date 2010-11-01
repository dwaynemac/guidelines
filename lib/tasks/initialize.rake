task :initialize => :environment do
  begin

    %(FR RS SC PR SP RJ MG  DF CE AR PT ENG ITA).each do |fed|
      Federation.create!(:name => fed)
    end



  rescue
    Federation.delete_all
  end


end