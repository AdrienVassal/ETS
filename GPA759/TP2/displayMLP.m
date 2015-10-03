classdef displayMLP
    %DISPLAYSIMPLE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        fig
        axes1
        axes2
    end
    
    methods
        
        function obj = initialize(obj)            
            % Create figure
            obj.fig = figure('Color',[1 1 1],'position',[150,150,900,600]);
             % Create axes
             % Create axes
            obj.axes1 = axes('Parent',obj.fig,...
                'ZColor',[0.4 0.4 0.4],...
                'YTickLabel',{'-4','-3','-2','-1','0','1','2','3','4'},...
                'YTick',[-4 -3 -2 -1 0 1 2 3 4],...
                'YGrid','on',...
                'YColor',[0.4 0.4 0.4],...
                'XTickLabel',{'-4','-3','-2','-1','0','1','2','3','4'},...
                'XGrid','on',...
                'XColor',[0.4 0.4 0.4],...
                'Position',[0.05 0.1 0.55 0.8]);
            
            xlim(obj.axes1,[-4 4]);
            ylim(obj.axes1,[-4 4]);
            box(obj.axes1,'on');
            hold(obj.axes1,'all');

            
            obj.axes2 = axes('Parent',obj.fig,...
                'Position',[0.65 0.1 0.3 0.47]);
        end
        
        function obj = plotState(obj,X,D,Y)
            axes(obj.axes1)
            
            obj.axes1 = axes('Parent',obj.fig,...
                'ZColor',[0.4 0.4 0.4],...
                'YTickLabel',{'-4','-3','-2','-1','0','1','2','3','4'},...
                'YTick',[-4 -3 -2 -1 0 1 2 3 4],...
                'YGrid','on',...
                'YColor',[0.4 0.4 0.4],...
                'XTickLabel',{'-4','-3','-2','-1','0','1','2','3','4'},...
                'XGrid','on',...
                'XColor',[0.4 0.4 0.4],...
                'Position',[0.05 0.1 0.55 0.8]);
            
            xlim(obj.axes1,[-4 4]);
            ylim(obj.axes1,[-4 4]);
            box(obj.axes1,'on');
            hold(obj.axes1,'all');

            
            X1C1 = X(D==1,1);
            X2C1 = X(D==1,2);
            X1C2 = X(D~=1,1);
            X2C2 = X(D~=1,2);
            
            sizeMarkers = 100;
            C1 = [0 0 1];
            C2 = [1 0 0];
            
            % Create scatter
            scatter(X1C1,X2C1,sizeMarkers,C1,'filled',...
                'DisplayName','Exemples de la classe +1');
            hold on
            % Create scatter
            scatter(X1C2,X2C2,sizeMarkers,C2,'filled',...
                'DisplayName','Exemples de la classe -1');
            hold on
            
                
            % print labels
            if ~isempty(Y)
                if sum(Y) ~= 0 
                    scatter(X(Y==1,1),X(Y==1,2),sizeMarkers*2,C1,'o',...
                        'DisplayName','Exemples classifiés +1');
                    hold on
                end
                if sum(Y) ~= size(Y,1);
                    scatter(X(Y~=1,1),X(Y~=1,2),sizeMarkers*2,C2,'o',...
                        'DisplayName','Exemples classifiés -1');
                    hold on
                end
            end
            
            % Create legend
            legend1 = legend(obj.axes1,'show');
            set(legend1,...
                'Position',[0.64 0.63 0.32 0.27]);
            xlim(obj.axes1,[-4 4]);
            ylim(obj.axes1,[-4 4]);
            hold off
        end
        
                
        function obj = plotMSE(obj,MSE)
            axes(obj.axes2)
         cla
            X = 1:length(MSE);
            
            % Create plot
            plot(X,MSE, 'color', [0.7 0 0],'LineWidth',2);
            title('MSE')
            hold off
        end
        
        function clean(obj)
           clf(obj.fig) 
        end
        
        
    end
    
end

