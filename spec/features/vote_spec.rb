feature '投票フェーズに遷移する' do
  before do
    using_session :viewer1 do
      visit '/'
      fill_in 'name', with: 'viewer1'
      click_button 'submit'
    end

    using_session :viewer2 do
      visit '/'
      fill_in 'name', with: 'viewer2'
      click_button 'submit'
    end

    using_session :viewer3 do
      visit '/'
      fill_in 'name', with: 'viewer3'
      click_button 'submit'
    end

    using_session :viewer1 do
      click_button 'Game Start'
    end
  end

  scenario '参加者の名前がボタンで一覧表示される', js: true do
    using_session :viewer1 do
      expect(page).to have_button 'viewer1'
      expect(page).to have_button 'viewer2'
      expect(page).to have_button 'viewer3'
    end
  end

  feature 'viewer1以外がviewer1へ投票する' do
    before do
      using_session :viewer1 do
        click_button 'viewer2'
      end

      using_session :viewer2 do
        click_button 'viewer1'
      end

      using_session :viewer3 do
        click_button 'viewer1'
      end
    end

    scenario '投票されたユーザとしてviewer1が表示される', js: true do
      using_session :viewer1 do
        expect(page).to have_content 'vote viewer1'
      end
    end
  end
end

