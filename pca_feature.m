basePath = '';


% read in data
    file_path_separator = '/';

    dataFile = strcat(basePath,'features',file_path_separator,'features.csv');
    data_tmp = dlmread(dataFile);
    pcaFileName = strcat('pca_features.csv');

    data_X = data_tmp(:,1:end-1);
    data_Y = data_tmp(:,end);

    %%n-by-p data matrix data_X(162X20)5 function for each sensor
    % Perform a principal component analysis of the data.
    % [coefs,score,latent,tsquare] = princomp(zscore(data_X));
    [coefs,score,latent,tsquare] = pca(zscore(data_X));

    %COEFF is a p-by-p matrix (15X15), each column containing coefficients for one principal component. 
    %'coeff' are the principal component vectors. These are the eigenvectors of the covariance matrix.
    %The columns are in order of decreasing component variance.

    %SCORE, the principal component scores(PC1,PC2,..PCp~PC32); that is, the representation of X in the principal component space. 
    %Rows of SCORE correspond to observations, columns to components.

    %latent -> a vector containing the eigenvalues of the covariance matrix of X

    %%%%%%%%%%%%%%Variance Check START%%%%%%%%%%%%%%%%%%%%%
%     figure(1)
%     boxplot(data_X)
%     title('Variance in features(without PCA) - box plot')
%     figure(2)
%     boxplot(score)
%     title('Variance in features(with PCA) - box plot')
    %%%%%%%%%%%%%%Variance Check END%%%%%%%%%%%%%%%%%%%%%

    % sensors = {'al','ar', 'emgl', 'emgr', 'gl', 'gr', 'ol', 'or' };
    % sensors_feature_count = {3, 23, 8, 8, 3, 23, 3 , 3};
    % vbls = {};
    % for i = 1:length(sensors)
    %     tmp = cell2mat(sensors_feature_count(i));
    %     for j = 1:tmp
    %         name = strcat(sensors(i), num2str(j));
    %         vbls = [vbls, {name}];
    %     end
    % end

    vbls = {};
    for i = 1:size(data_X, 2)
        val = strcat('X', num2str(i));
        val = char(val);
        vbls = [vbls, val];
    end
    obls = char(data_Y);

    %%%%%%%%%%%%%%For first two Principal Components START%%%%%%%%%%%%%%%%%%%%%
%     figure(3)
%     biplot(coefs(:,1:2),'scores',score(:,1:2),'varlabels',vbls,'obsLabels',obls);
%     title('First two PC -- Biplot')
%     figure(6)
%     colors = jet(10);
%     gscatter(score(:,1),score(:,2),data_Y,colors,['.','.','.','.','.','.','.','.','.','.']);
%     title('First two PC -- ScatterPlot')
%     xlabel('PC1');
%     ylabel('PC2');
    %%%%%%%%%%%%%%For first two Principal Components END%%%%%%%%%%%%%%%%%%%%%%%

    % %%%%%%%%%%%%%%For first three Principal Components START%%%%%%%%%%%%%%%%%%%
    figure(7)
    biplot(coefs(:,1:3),'scores',score(:,1:3),'varlabels',vbls,'obsLabels',obls);
    title('First three PC -- Biplot')
    figure(8)
    [unique_groups, ~, group_idx] = unique(data_Y);
    num_groups = size(unique_groups, 1);
    group_names = mat2cell( unique_groups, ones(1, num_groups), size(unique_groups, 2) );
    scatter3(score(:,1),score(:,2),score(:,3),20,group_idx);
    cmap = jet(num_groups);
    colormap( cmap );
    for ii = 1:size(cmap,1)
        p(ii) = patch(NaN, NaN, cmap(ii,:));
        lbl{ii} = num2str(unique_groups(ii));
    end
    legend(p,char(lbl));
    xlabel('PC1');
    ylabel('PC2');
    zlabel('PC3');
    title('First three PC -- ScatterPlot')
    % %%%%%%%%%%%%%%For first three Principal Components END%%%%%%%%%%%%%%%%%%%%%

    pca_features = [score(:,1:35) data_Y];
%     pca_file = strcat(basePath,'pca_features',file_path_separator,pcaFileName);
    dlmwrite(pcaFileName,pca_features);
    
    
    %Saving the coefs
    save('pca_coef.mat','coefs' );
% model_nm = 'models/SVM_model';
% saveCompactModel(CMdl, model_nm), model_nm)
