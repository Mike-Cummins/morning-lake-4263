require 'rails_helper'

RSpec.describe 'Project Show Page' do
  describe 'When I visit a Projects show page' do
    before :each do
      @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
      @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
      @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
      @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
      @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
      @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
      @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
      @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
      @erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)
      ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
      ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
      ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
      ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
      ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
      ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)
    end
      
    it 'Displays the project name and material' do
      visit "/projects/#{@news_chic.id}"

      expect(page).to have_content("#{@news_chic.name}")
      expect(page).to have_content("#{@news_chic.material}")
    end

    it 'Displays the project theme' do
      visit "/projects/#{@news_chic.id}"

      expect(page).to have_content("#{@recycled_material_challenge.theme}")    
    end

    it 'Displays the nnumber of contestants on that project' do
      visit "/projects/#{@news_chic.id}"

      expect(page).to have_content("Number of Contestants: 2")
    end

    it 'shows the average experience in years for the contestants' do
      visit "/projects/#{@news_chic.id}"

      expect(page).to have_content("Average Years of Contestant's Experience: 12.5")
    end

    it 'has a form to add a contestant to the project' do
      visit "/projects/#{@news_chic.id}"

      expect(page).to have_content("Number of Contestants: 2")

      fill_in('contestant_id', with: @kentaro.id)
      click_on("Add Contestant To Project")

      expect(current_path).to eq("/projects/#{@news_chic.id}")
      expect(page).to have_content("Number of Contestants: 3")

      visit "/contestants"

      within "#contestant_#{@kentaro.id}"
        expect(page).to have_content(@news_chic.name)
      end
    end
  end
