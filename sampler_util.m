classdef sampler_util
   properties
      feature = 0.0
   end
    
    methods
        
    %XY - test includes testing features and labels
    % For now, it assumes that there are two classes and positive class is
    % in less number
    % Positive class label is passed as argument and all other classes has
    % to be considered negative and other classes should be undersampled to
    % and count of all other classes should be equal to count of positive
    % classes
    function XY_training_new = undersample(obj,XY_training, positive_class_label)       % Undersamples test data
      y_training_unique = unique(XY_training(:, end));
      positive_count = length(find(XY_training(:,end) == positive_class_label));
      negative_label_count = length(find(XY_training(:,end) ~= positive_class_label));
      unique_negative_label_count = length(unique(XY_training(:,end) )) - 1;
      XY_training_new = [];
      curr_class_label = 0;
      curr_label_count = 0;
      max_negative_label_limit = round(positive_count /  unique_negative_label_count) + 1;
      for i = 1:length(XY_training)
          if curr_class_label == 0
              curr_class_label = XY_training(i, end);
          else
              if curr_class_label ~= XY_training(i, end)    %Label is changed
                  curr_label_count = 1;
                  curr_class_label = XY_training(i, end);
              else
                  curr_label_count = curr_label_count + 1;
              end
          end
          if (curr_class_label == positive_class_label) | (curr_label_count <= max_negative_label_limit)
              XY_training_new = [XY_training_new; XY_training(i, :)];
          end
      end
      XY_training_new = XY_training_new;
    end

   
    
   end
end
