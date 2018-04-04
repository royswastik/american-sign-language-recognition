function plot_util(x, y, ttl, xlbl, ylbl, file_path, file_nm)
    h = figure('visible','off');
    for cnt = 1:y.Count
      plot(x,cell2mat(y(cnt)))
      hold on
    end
    title(ttl)
    ylabel(xlbl)
    xlabel(ylbl)
    hold off
    full_fl_path = fullfile(char(file_path),'',char(file_nm));
    saveas(h,full_fl_path)
end